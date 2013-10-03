From: csd_b@daudt.org (Christian Daudt)
Date: Wed, 2 Oct 2013 23:22:55 -0700
Subject: [PATCH v2] ARM: bcm: Add DEBUG_LL console support
In-Reply-To: <1379462711-6957-1-git-send-email-csd@broadcom.com>
References: <1379462711-6957-1-git-send-email-csd@broadcom.com>
Message-ID: <CAGFynZ8_=0pEZUWmfw4Rwg+PM47=4=w-vdTBpZ9zBxO+RanYsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 17, 2013 at 5:05 PM, Christian Daudt <csd@broadcom.com> wrote:
> This patch adds low level debug uart support to Broadcom
>  mobile based SOCs.
>
> Signed-off-by: Christian Daudt <csd@broadcom.com>
>
> Changes from V1:
>  - Switched to use the common 8250 debug introduced in 3.12-rc1
>
Hi Russell,
 Are you okay with v2 of DEBUG_LL support for Broadcom mobile SoC ? If
so, should I submit it through your patchqueue ?

 Thanks,
   csd
