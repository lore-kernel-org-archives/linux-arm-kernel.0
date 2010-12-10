From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 10 Dec 2010 09:10:30 -0800
Subject: [PATCH] msm: trout: add keypad support
In-Reply-To: <4D01D776.6000309@codeaurora.org>
References: <1291854285-29566-1-git-send-email-dwalker@codeaurora.org>
	<4D00800E.7050004@codeaurora.org>
	<1291916733.18827.1.camel@c-dwalke-linux.qualcomm.com>
	<AANLkTi=3LHHNJUh35AUkq--KtRCnRaBHx8Ky2bhxxzE4@mail.gmail.com>
	<1291932216.18827.16.camel@c-dwalke-linux.qualcomm.com>
	<4D01D776.6000309@codeaurora.org>
Message-ID: <1292001031.8027.9.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-12-10 at 13:02 +0530, Trilok Soni wrote:

> To support this, we need to override the input device .name and submit the patches
> for matrix keypad and gpio keys and let the name come through platform data. 
> 
> You can refer how I am doing in PM8058 keypad driver patch.

ok ..

> But the real question is why can't we just do this in userspace? we should be able
> to override the keymap using setkeycode functionality, isn't it?

It might be possible, but some of the keys are missing in some of the
configurations .. If you had one big configuration with all of the gpio
lines, it might be possible that the missing gpio lines aren't
configured or don't exist.

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
