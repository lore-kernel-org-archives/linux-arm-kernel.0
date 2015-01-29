From: broonie@kernel.org (Mark Brown)
Date: Thu, 29 Jan 2015 11:07:44 +0000
Subject: [RFC V2] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <CAKohpokxdpF2nTeOnDpofNM1vW3aZRyDBE3WKmvZ8wJedf-TGw@mail.gmail.com>
References: <CAKohpokxdpF2nTeOnDpofNM1vW3aZRyDBE3WKmvZ8wJedf-TGw@mail.gmail.com>
Message-ID: <20150129110744.GU21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 29, 2015 at 07:09:23AM +0530, Viresh Kumar wrote:
> On 29 January 2015 at 01:36, Mark Brown <broonie@kernel.org> wrote:

> >> +  Required properties:
> >> +  - compatible: allow OPPs to express their compatibility.
> >> +  - opp-list: phandle to opp-list defined above.

> > I don't understand what that compatible property is intended to mean and
> > I expect other readers might be similarly confused - is it a standard
> > compatbile property meaning this noe corresponds to some sort of device?

> The goal is to choose the driver which we want to probe for a platform. There
> can be multiple DT enabled cpufreq drivers present in a build and the platform
> needs some way to choose one of them.

So you need to document this as a platform device then if that's what
you're doing here; there's more than just specifying a compatible string
involved.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150129/9de5263e/attachment.sig>
