From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 2 Jul 2014 11:19:27 +0100
Subject: [PATCH 3/3] ARM: STi: STiH407: Add reset controller support.
In-Reply-To: <20140702085102.GF10311@lee--X1>
References: <1404225047-9495-1-git-send-email-peter.griffin@linaro.org>
 <1404225047-9495-4-git-send-email-peter.griffin@linaro.org>
 <20140702085102.GF10311@lee--X1>
Message-ID: <20140702101927.GC8809@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

> > +		picophyreset: picophyreset-controller {
> > +			#reset-cells = <1>;
> > +			compatible = "st,stih407-picophyreset";
> > +		};
> > +
> 
> I'd always put the compatible string at the very top of the node.

Thanks for reviewing, have changed in v2.

regards,

Peter.
