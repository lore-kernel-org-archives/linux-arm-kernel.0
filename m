From: baruch@tkos.co.il (Baruch Siach)
Date: Fri, 15 Dec 2017 10:27:59 +0200
Subject: [PATCH v3 01/11] dt-bindings: thermal: Describe Armada AP806 and
 CP110
In-Reply-To: <20171214103011.24713-2-miquel.raynal@free-electrons.com>
References: <20171214103011.24713-1-miquel.raynal@free-electrons.com>
 <20171214103011.24713-2-miquel.raynal@free-electrons.com>
Message-ID: <20171215082759.7t24ka3lpkulcb7r@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel

On Thu, Dec 14, 2017 at 11:30:01AM +0100, Miquel Raynal wrote:
> +- marvell,thermal-zone-name: The name to identify the thermal zone
> +                             within the sysfs, useful when multiple
> +                             thermal zones are registered (AP, CPx...).

I don't think that would be acceptable. DT is about describing the hardware. 
sysfs is a Linux implementation detail which is not tied to any specific 
hardware. If this is accepted, the property should be named 
'linux,thermal-zone-name'.

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
