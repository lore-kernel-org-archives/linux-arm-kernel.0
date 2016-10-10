From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Mon, 10 Oct 2016 08:00:30 +0200
Subject: [PATCH 0/2] ARM: at91: properly handle LPDDR poweroff
In-Reply-To: <20161007163427.11454-1-alexandre.belloni@free-electrons.com>
References: <20161007163427.11454-1-alexandre.belloni@free-electrons.com>
Message-ID: <1791580.DIVsjjyavb@ws-stein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Friday 07 October 2016 18:34:25, Alexandre Belloni wrote:
> Hi,
> 
> This patch set improves LPDDR support on SoCs using the Atmel MPDDR
> controller.
> 
> LPDDR memoris can only handle up to 400 uncontrolled power offs in their
> life. The proper power off sequence has to be applied before shutting down
> the SoC.
> 
> I'm not too happy with the code duplication but this is a design choice
> that has been made before because both shitdown controler are really
                                         ^^^^^^^^

I guess you mean shutdown? :) Same for the suject of 2nd patch.

Best regards,
Alexander
