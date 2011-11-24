From: mchehab@redhat.com (Mauro Carvalho Chehab)
Date: Thu, 24 Nov 2011 16:05:24 -0200
Subject: [PATCH RESEND] davinci: dm646x: move vpif related code to driver
 core header from platform
In-Reply-To: <1321110362-6699-1-git-send-email-manjunath.hadli@ti.com>
References: <1321110362-6699-1-git-send-email-manjunath.hadli@ti.com>
Message-ID: <4ECE8764.60800@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em 12-11-2011 13:06, Manjunath Hadli escreveu:
> move vpif related code for capture and display drivers
> from dm646x platform header file to vpif_types.h as these definitions
> are related to driver code more than the platform or board.
> 
> Signed-off-by: Manjunath Hadli <manjunath.hadli@ti.com>

Manju,

Why are you re-sending a patch?

My understanding is that you're maintaining the davinci patches, so it is
up to you to put those patches on your tree and send me a pull request when
they're done. So, please, don't pollute the ML re-sending emails that
are for yourself to handle.

Regards,
Mauro.
