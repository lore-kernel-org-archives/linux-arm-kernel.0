From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Fri, 2 Mar 2018 12:42:14 +0100
Subject: [PATCH 2/2] drm/sun4i: add lvds mode_valid function
In-Reply-To: <20180301095721.4iga7dcgg566j44m@flea>
References: <1519840432-61489-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1519840432-61489-2-git-send-email-giulio.benetti@micronovasrl.com>
 <20180301095721.4iga7dcgg566j44m@flea>
Message-ID: <ebe7cfe5-e731-10cf-17cd-fe79bee0fdc4@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Il 01/03/2018 10:57, Maxime Ripard ha scritto:
> On Wed, Feb 28, 2018 at 06:53:52PM +0100, Giulio Benetti wrote:
>>   static struct drm_connector_helper_funcs sun4i_lvds_con_helper_funcs = {
>>   	.get_modes	= sun4i_lvds_get_modes,
>> +	.mode_valid	= sun4i_lvds_mode_valid,
>>   };
> 
> This should be on the encoder, not the connector.

I've seen it is bound to connector in rgb and to encoder in hdmi.
Is it correct rgb mode_valid under connector funcs?
Otherwise I send a patch also for that one.

> 
> Maxime
> 
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 


-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ? 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642
