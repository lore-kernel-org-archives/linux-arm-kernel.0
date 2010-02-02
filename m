From: a.zummo@towertech.it (Alessandro Zummo)
Date: Tue, 2 Feb 2010 09:22:20 +0100
Subject: [rtc-linux] [PATCH v3] rtc: driver for the DryIce block found
	in  i.MX25 chips
In-Reply-To: <f0c75e5d2252a4abc5c2ef480d173a4039c44a5c.1265093096.git.baruch@tkos.co.il>
References: <20100201102057.4937155f@linux.lan.towertech.it>
	<f0c75e5d2252a4abc5c2ef480d173a4039c44a5c.1265093096.git.baruch@tkos.co.il>
Message-ID: <20100202092220.26869dc4@linux.lan.towertech.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  2 Feb 2010 08:47:04 +0200
Baruch Siach <baruch@tkos.co.il> wrote:

> 
> Changes v2 -> v3:
> 
> Add spaces around the '+' operator as suggested by Alessandro Zummo and Lothar 
> Wa?mann.
> 
> Address other comments of Alessandro Zummo:
> 
> 	* add implementation of the alarm_irq_enable rtc op
> 	* use devres in .probe
> 	* remove unneeded initializations

 I believe you sent the old version ;)

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
