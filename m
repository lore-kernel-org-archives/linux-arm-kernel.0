From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 06 Oct 2011 17:42:45 +0200
Subject: [PATCH 1/3] sam9g20ek/9m10g45ek/stam9g20: unbreak build after
	'use -EINVAL for invalid gpio'
In-Reply-To: <1317915587-27474-1-git-send-email-jacmet@sunsite.dk> (Peter
	Korsgaard's message of "Thu, 6 Oct 2011 17:39:47 +0200")
References: <1317915587-27474-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <87aa9e3z4a.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Peter" == Peter Korsgaard <jacmet@sunsite.dk> writes:

 Peter> Commit 36706ab70b26 (ARM: at91/boards: use -EINVAL for invalid gpio)
 Peter> broke the build as it used ';' rather than ',' in structure initializers.

Ups, ignore the 1/3 part, this is the only patch in this series.

-- 
Bye, Peter Korsgaard
