From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 12 May 2017 13:16:54 +0200
Subject: [PATCH 1/2] ARM: at91/defconfig: make system tickless when idle
In-Reply-To: <00d91ef0-14f8-6065-2208-f4d7116adab7@free-electrons.com>
References: <20170505084343.10417-1-quentin.schulz@free-electrons.com>
 <00d91ef0-14f8-6065-2208-f4d7116adab7@free-electrons.com>
Message-ID: <20170512111654.fn63hpsxvfqg4dkt@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2017 at 08:39:50 +0200, Quentin Schulz wrote:
> Hi all,
> 
> On 05/05/2017 10:43, Quentin Schulz wrote:
> > This makes Atmel sama5 platforms' system tickless when idle.
> > 
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> 
> It's been a week since I posted this patch series. Any comment?
> 

No but this was too late for the previous release and v4.12-rc1 is not
tagged yet so I can't base the dt branch on it.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
