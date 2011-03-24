From: davidb@codeaurora.org (David Brown)
Date: Thu, 24 Mar 2011 15:39:13 -0700
Subject: [PATCH] msm: Add gpio support for 8960
In-Reply-To: <1300933467.6117.49.camel@m0nster> (Daniel Walker's message of
	"Wed, 23 Mar 2011 19:24:27 -0700")
References: <1300402640-23995-1-git-send-email-rvaswani@codeaurora.org>
	<1300885151.6117.11.camel@m0nster> <4D8A88AE.2000701@codeaurora.org>
	<1300933467.6117.49.camel@m0nster>
Message-ID: <8yaoc5016um.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 23 2011, Daniel Walker wrote:

> Should let everyone know exactly what your doing, even breaking up the
> changes into specific patches.

Rohit, but other MSM developers as well.  In general, the commit text
needs to be a lot better.  A good test would be to look at each part of
the patch, and ask how that is described by the commit text.  If it
feels like the commit text is describing separate things, the patch
probably needs to be split up.

Please spend some time running 'git log' on other parts of the kernel to
get a feel for what is expected.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
