From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 26 Nov 2012 14:49:44 +0000
Subject: [RFC PATCH] ASoC: Samsung: Register the audio platform device
In-Reply-To: <CAAgF-BdHm_VFB-xsZ6kpAu5+9+1yMNVVGM_og+H3QghWQuf8+w@mail.gmail.com>
References: <1352894960-17434-1-git-send-email-padma.v@samsung.com>
 <1352894960-17434-2-git-send-email-padma.v@samsung.com>
 <CAAgF-BdHm_VFB-xsZ6kpAu5+9+1yMNVVGM_og+H3QghWQuf8+w@mail.gmail.com>
Message-ID: <20121126144943.GM9411@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 08:15:12PM +0530, Padma Venkat wrote:
> On Wed, Nov 14, 2012 at 5:39 PM, Padmavathi Venna <padma.v@samsung.com> wrote:

> > +module_init(smdk_audio_init);
> > +module_exit(smdk_audio_exit);

> Ping. Any comments on this patch?

Don't send contentless pings and delete irrelevant context from replies.
Please refer to the feedback I sent in response to Sangbeom's pull
request - in short, this isn't the way to do this - do what the other
platforms do.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121126/226146c4/attachment.sig>
