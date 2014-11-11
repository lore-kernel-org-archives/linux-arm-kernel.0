From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Tue, 11 Nov 2014 10:34:16 -0800
Subject: [RFC 2/2] regulator: qcom-rpm: Implement RPM assisted disable
In-Reply-To: <5461D2BD.2080209@suse.de>
References: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1415659966-16200-3-git-send-email-bjorn.andersson@sonymobile.com>
 <5461D2BD.2080209@suse.de>
Message-ID: <20141111183414.GE16980@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 11 Nov 01:11 PST 2014, Andreas F?rber wrote:

> Hi,
> 
> Am 10.11.2014 um 23:52 schrieb Bjorn Andersson:
> > diff --git a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
> > index 4264021..4671eef 100644
> > --- a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
> > +++ b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
> > @@ -112,6 +112,13 @@ of valid subnodes that can operate on these resources.
> >  	Definition: select that the power supply should operate in hysteretic
> >  		    mode, instead of the default pwm mode
> >  
> > +- qcom,rpm-assisted-disable:
> > +	Usage: optional
> > +	Value type: <empty>
> > +	Definition: select that the regulator is supplying the active CPU(s)
> > +		    and can only be disabled with the assistans from the RPM
> 
> "assistance"
> 

Thanks

Regards,
Bjorn
