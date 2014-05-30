From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 May 2014 14:53:22 +0100
Subject: [RFC PATCH 04/11] coresight: add CoreSight ETB driver
In-Reply-To: <1401457391-12242-5-git-send-email-mathieu.poirier@linaro.org>
References: <1401457391-12242-1-git-send-email-mathieu.poirier@linaro.org>
 <1401457391-12242-5-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20140530135321.GQ3693@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

NAK for all the reasons I mentioned in the previous submission in 2012.

You partially did the right thing - you read through the previous
submission, and you said in your cover message that you had addressed
some of the comments from that submission.

What I find extremely distasteful is that you seem to have chosen to
completely ignore my comments - you haven't mentioned them in your
covering message at all, and you've just gone ahead and converted ETM
and ETB to be platform devices.

That gets you a NAK for that change, because you have done nothing what
so ever to address the concerns I raised.

Since you seem to have ignored my comments, this is as far as I'm looking
at your submission, and you can consider the entire submission NAK'd by
me.

Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
