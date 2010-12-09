From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 09 Dec 2010 09:45:33 -0800
Subject: [PATCH] msm: trout: add keypad support
In-Reply-To: <4D00800E.7050004@codeaurora.org>
References: <1291854285-29566-1-git-send-email-dwalker@codeaurora.org>
	<4D00800E.7050004@codeaurora.org>
Message-ID: <1291916733.18827.1.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-12-09 at 12:36 +0530, Trilok Soni wrote:

> > +static char *keycaps = "--qwerty";
> > +#undef MODULE_PARAM_PREFIX
> > +#define MODULE_PARAM_PREFIX "board_trout."
> > +module_param_named(keycaps, keycaps, charp, 0);
> 
> I would like to know what is the use of this param?

No idea .. It was part of Google's implementation ..

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
