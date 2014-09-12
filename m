From: dianders@chromium.org (Doug Anderson)
Date: Fri, 12 Sep 2014 09:03:50 -0700
Subject: [PATCH RESEND v9 1/5] rtc: max77686: Allow the max77686 rtc to
 wakeup the system
In-Reply-To: <5413173A.9070705@collabora.co.uk>
References: <1410509864-10019-1-git-send-email-javier.martinez@collabora.co.uk>
 <1410509864-10019-2-git-send-email-javier.martinez@collabora.co.uk>
 <CAD=FV=Vu3u=KfUNUpL6qcr0Fp42WbY8AqfOXyWr-D3KW1PucxA@mail.gmail.com>
 <5413173A.9070705@collabora.co.uk>
Message-ID: <CAD=FV=W3soOh2yf0pDcP0cXVGvxcbyTkO7z-1k0rV7DJAyhf=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 12, 2014 at 8:54 AM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> You are right, I completely forgot to check if that actually landed and to
> remove the note in that case...
>
> Maybe when the set is applied the note can be removed from this patch or do
> you think that I should re-spin the series for that?

This seems like something a maintainer could handle removing, but I
guess it's totally up to the maintainer.  If I were the maintainer I'd
rather remove the note myself then see a whole spin of a 5-part series
just to fix this.  ;)


-Doug
