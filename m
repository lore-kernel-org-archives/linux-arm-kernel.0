From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Thu, 10 Feb 2011 01:26:17 +0300
Subject: [PATCH 0/6] Switch pxa25x_udc devices to use gpio-vbus tranceiver
In-Reply-To: <1296666003-31647-1-git-send-email-dbaryshkov@gmail.com>
References: <1296666003-31647-1-git-send-email-dbaryshkov@gmail.com>
Message-ID: <AANLkTinyE+LFpiiy1v71n2-R+DP2A_q93rRnEVtG6VAV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2/2/11, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
> pxa25x_udc driver contains functionality duplicating gpio-vbus tranceiver
> functions. Switch all devices, that depend on it, to use gpio-vbus
> and (in the last patches) drop related code from pxa25x_udc.

Any comments on this patchset?

-- 
With best wishes
Dmitry
