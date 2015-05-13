From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 May 2015 16:07:39 +0100
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <CAGo_u6o5nw8C3uwLGmP+kbCOG5twmXgC2ATb5Gv-dL3G-grDSg@mail.gmail.com>
References: <20150507221842.GW22845@sirena.org.uk>
 <CAKohpomU8wm0T=A7EkosdOjXbP8q2Cb726Hsjh08KTKYjoz3-A@mail.gmail.com>
 <555000B6.2010107@ti.com> <20150512052033.GC32300@linux>
 <20150512190134.16410.89041@quantum> <5552510B.9010306@ti.com>
 <20150512194134.GC3066@sirena.org.uk> <55525B29.2080307@ti.com>
 <20150513115422.GQ3066@sirena.org.uk>
 <CAGo_u6o5nw8C3uwLGmP+kbCOG5twmXgC2ATb5Gv-dL3G-grDSg@mail.gmail.com>
Message-ID: <20150513150739.GW2761@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 13, 2015 at 09:24:57AM -0500, Nishanth Menon wrote:

> - opp-microamp: The maximum current drawn by the device in microamperes
>   considering system specific parameters (such as transients, process,
> aging, etc.)
>   as necessary,  at an  ambient temperature of 25C. This may be used to set
>   the most efficient regulator operating mode.

Why specify the temperature?  That 25C is going to be terribly
inefficient for my snowplow engine control system (or whatever).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/f1dd4012/attachment.sig>
