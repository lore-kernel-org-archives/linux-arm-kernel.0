From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 29 Jan 2010 20:56:45 +0100
Subject: [PATCH 3/4] rtc: enable rtc in max8925
In-Reply-To: <771cded01001250355p71099663j385d25fc63a5d63d@mail.gmail.com>
References: <771cded01001250309x33f85bbah4db8b526f6706309@mail.gmail.com>
	<20100125122231.3d4ddc02@linux.lan.towertech.it>
	<771cded01001250355p71099663j385d25fc63a5d63d@mail.gmail.com>
Message-ID: <20100129195644.GC23130@sortiz.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Mon, Jan 25, 2010 at 06:55:50AM -0500, Haojian Zhuang wrote:
> +struct max8925_rtc_info {
> +	struct rtc_device	*rtc_dev;
> +	struct max8925_chip	*chip;
> +	struct i2c_client	*i2c;
I dont think you need this pointer here, right ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
