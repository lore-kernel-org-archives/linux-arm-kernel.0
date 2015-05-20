From: stefan@agner.ch (Stefan Agner)
Date: Wed, 20 May 2015 08:08:09 +0200
Subject: [PATCH v2 0/2] Implement SoC bus support for Vybrid
In-Reply-To: <cover.1432099651.git.maitysanchayan@gmail.com>
References: <cover.1432099651.git.maitysanchayan@gmail.com>
Message-ID: <283beb50db48f2a7a43dcdd249e4d93e@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-20 07:36, Sanchayan Maity wrote:
> Sanchayan Maity (2):
>   ARM: dts: vfxxx: Add OCOTP and OCROM nodes
>   ARM: vf610: Add SoC bus support for Vybrid
> 
>  arch/arm/boot/dts/vfxxx.dtsi   | 10 +++++
>  arch/arm/mach-imx/mach-vf610.c | 85 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 93 insertions(+), 2 deletions(-)


This patchset
Acked-by: Stefan Agner <stefan@agner.ch>

Shawn, speaking of Ack, the current plan is to merge the Vybrid
Cortex-M4 patches directly into the arm-soc tree. If you are ok with
them, could I have your Ack on them (sent out a split version of them
(v8) some hours ago).

--
Stefan
