From: catalin.crenguta@gmail.com (Catalin Crenguta)
Date: Wed, 18 Nov 2015 12:00:05 +0200
Subject: Freescale IMX6 active cooling
In-Reply-To: <564C0453.6020400@kosagi.com>
References: <CABH3fy-He02iVU7FzqcPApPemeoqQP15+gr9+Hx87-OEBuHvCg@mail.gmail.com>
 <CAOMZO5AX9owvovpdmdr=rKNApbuNrkp9pKexJk_mMyMdH1=1qg@mail.gmail.com>
 <CALHpu37MNnzW=3YNKUq-aOHgF12EhjyN7g1juTwuMad_Xv891w@mail.gmail.com>
 <CABH3fy-QPV1bv-WaO3mWVq2RN5=f-AnBHMgFTmmU-Ve3xgyUrw@mail.gmail.com>
 <564C0453.6020400@kosagi.com>
Message-ID: <CABH3fy-UY7YdbaaZxymfcaxnhsNkozeRD9uUU5DOQH2S50sEXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 18, 2015 at 6:53 AM, Sean Cross <xobs@kosagi.com> wrote:
> Perhaps the correct order of patches is:
>
> 1) Add generic thermal zone support
> 2) Remove zone and cdev from imx_thermal
> 3) Add cpufreq-cooling to imx6
> 4) Add cpufreq-cooling to all other SoCs that support imx_thermal
> 5) Add default generic thermal zone support to imx6qdl.dtsi
In my opinion, I guess a patch series containing this would be good.

Thanks again!
