From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 28 Jan 2012 18:57:45 -0200
Subject: [RFC PATCH] ARM ASoC: add sound driver for imx27pdk using mc13783
 codec
In-Reply-To: <2667396.yifGumf5nD@laptop>
References: <1310131491-625-1-git-send-email-J.Lambrecht@televic.com>
 <4E1711EA.5070209@televic.com>
 <201107271028.09928.philippe.retornaz@epfl.ch>
 <2667396.yifGumf5nD@laptop>
Message-ID: <CAOMZO5CRmvwCy_qE81PauZ6jmPN7S3N3pky01V0OmWBLCJ5JyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philippe,

On Wed, Jan 25, 2012 at 1:45 PM, Philippe R?tornaz
<philippe.retornaz@epfl.ch> wrote:

> I have a working sound support for the mx31moboard boards available here:
> http://github.com/retornaz/linux/commits/moboard-sound

That's cool :-)

> It's basically Sascha mc13783 codec driver (from his git tree) rebased on 3.2
> and some mx31moboad specific code.
>
> I can playback & record sound on our board (2 channels at 16Khz) with the sdma.
>
> Sascha, do you have any plan to upstream the mc13783 codec driver ?

In case Sascha doesn't have plans to upstream mc13783, is this
something you could do?

Thanks,

Fabio Estevam
