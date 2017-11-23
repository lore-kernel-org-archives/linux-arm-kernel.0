From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 23 Nov 2017 13:08:44 -0200
Subject: [PATCH 1/5] drm/panel: Add support for the EDT ETM0700G0BDH6
In-Reply-To: <20171123125600.41562-2-jan.tuerk@emtrion.com>
References: <20171123125600.41562-1-jan.tuerk@emtrion.com>
 <20171123125600.41562-2-jan.tuerk@emtrion.com>
Message-ID: <CAOMZO5D_xAWAnuH47BjAt4xNtz=c2dGn+kL6X8gW_auOTmDq5g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jan,

On Thu, Nov 23, 2017 at 10:55 AM, Jan Tuerk <jan.tuerk@emtrion.com> wrote:
> The Emerging Display Technology ETM0700G0BDH6 is exactly
> the same display as the ETM0700G0DH6, exept the pixelclock
> polarity. Therefore re-use the ETM0700G0DH6 modes. It is
> used by default on emtrion Avari based development kits.
>
> Signed-off-by: Jan Tuerk <jan.tuerk@emtrion.com>

Please run ./scripts/checkpatch.pl on your patch. Currently it gives:
total: 18 errors, 13 warnings, 39 lines checked

Please fix and resend. Also, you could try git send-email in the next time.

Regards,

Fabio Estevam
