From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Fri, 11 Jul 2014 18:11:41 +0300
Subject: [PATCH 12/13] cpufreq: Add cpufreq driver for Tegra124
In-Reply-To: <20140711145735.GB6523@ulmo>
References: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>
 <1405028569-14253-13-git-send-email-ttynkkynen@nvidia.com>
 <CAKohpom9ORXFiUU4=V+CxgN0ZOFLMEhEjHiU8HsYUYDybNXgHQ@mail.gmail.com>
 <20140711091207.GY23218@tbergstrom-lnx.Nvidia.com>
 <20140711145735.GB6523@ulmo>
Message-ID: <53BFFEAD.7000405@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/14 17:57, Thierry Reding wrote:

>> I don't think that's going to work? The voltage scaling is handled in hw.
>
> Do we have to handle it in hardware or can we opt to do it in software,
> too?
>

With the PLLX, voltage scaling is done entirely in SW. With the DFLL,
it's possible to stay in open-loop mode and do it in SW, but there's
not much point in that.

-- 
nvpublic
