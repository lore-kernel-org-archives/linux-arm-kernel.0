From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Fri, 30 May 2014 10:50:56 +0300
Subject: [PATCH v2 4/4] ARM: debug: qcom: add UART addresses to Kconfig
 help
In-Reply-To: <CABuKBeLHOKK+DsVPBGPDmeSqceSTMGZeOd74-Jp4Z9vUWDZ_yQ@mail.gmail.com>
References: <1400857952-6963-1-git-send-email-gdjakov@mm-sol.com>
 <1400857952-6963-5-git-send-email-gdjakov@mm-sol.com>
 <CABuKBe+B_Ga-w4aA4dApDTa26rCuhetRTJku27Madm+fHtDcLA@mail.gmail.com>
 <53834578.9090305@mm-sol.com>
 <CABuKBeJXqSi=6XY5Fg7mg_daQ4D8ornS-kn7NDPktCtro7yNNw@mail.gmail.com>
 <53847FA1.60509@mm-sol.com>
 <CABuKBeLHOKK+DsVPBGPDmeSqceSTMGZeOd74-Jp4Z9vUWDZ_yQ@mail.gmail.com>
Message-ID: <1401436256.13544.7.camel@iivanov-dev>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-05-29 at 17:26 +0200, Matthias Brugger wrote:

> IMHO the dependancy is that DEBUG_LL uses the uart device, and this is
> added when you add the dts.
> AFAIK there can arise problems with multi-platform kernels if the uart
> is not present.

Once DEBUG_LL is enabled you don't have multi-platform kernel anymore,
so this should not be an issue here.

Regards,
Ivan
