From: B47053@freescale.com (Li Xiubo)
Date: Fri, 1 Nov 2013 07:52:57 +0000
Subject: [PATCHv1 0/8] ALSA: Add SAI driver and enable SGT15000 codec
In-Reply-To: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828718C5@039-SN2MPN1-013.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, forgot the Subject!

Sent again.


> 
> Hello,
> 
> This patch series is mostly Freescale's SAI SoC Digital Audio Interface
> driver implementation. And the implementation is only compatible with
> device tree definition.
> 
> This patch series is based on linux-next and has been tested on Vybrid
> VF610 Tower board using device tree.
> 
> Changed in v2:
> - Use default settings for the generic dmaengine PCM driver.
> - Separate receive and transmit setting in most functions, but some
> couldn't for the HW limitation.
> - Drop some not reduntant code.
> - Use devm_snd_soc_register_component() instead of
> snd_soc_register_component().
> - Use devm_snd_soc_register_card() instead of
> devm_snd_soc_register_card().
> - Adjust the code sentences sequence.
> - Make the namespacing consistent.
> - Rename CONFIG_SND_SOC_FSL_SGTL5000 to CONFIG_SND_SOC_FSL_SGTL5000_VF610.
> - Drop some meaningless lines.
> - Rename the binding document file.
> 
> Added in v1:
> - Add SAI SoC Digital Audio Interface driver.
> - Add Freescale SAI ALSA SoC Digital Audio Interface node for VF610.
> - Enables SAI ALSA SoC DAI device for Vybrid VF610 TOWER board.
> - Add device tree bindings for Freescale SAI.
> - Revise the bugs about the sgt15000 codec.
> - Add SGT15000 based audio machine driver.
> - Enable SGT15000 codec based audio driver node for VF610.
> - Add device tree bindings for Freescale VF610 sound.
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
