From: broonie@kernel.org (Mark Brown)
Date: Fri, 8 May 2015 11:58:57 +0100
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <CAKohpomU8wm0T=A7EkosdOjXbP8q2Cb726Hsjh08KTKYjoz3-A@mail.gmail.com>
References: <CAKohponRXiWbgT26=tO83jJgbteBf38ggE7mKvLCv+wFMW1cvA@mail.gmail.com>
 <20150505105714.GA22845@sirena.org.uk>
 <CAKohpo=09ZhXxh5Cm7Ww9Gy-AYRp9=j82tup6atVN+aOF8twdA@mail.gmail.com>
 <20150505171252.GI22845@sirena.org.uk>
 <CAKohpo=kJs076afzERPMqjELgwpN6nR2yoyEjW6XY7YSEbRuCA@mail.gmail.com>
 <20150507055231.GB32399@codeaurora.org>
 <20150507110233.GR15510@sirena.org.uk>
 <20150507211855.GA2455@codeaurora.org>
 <20150507221842.GW22845@sirena.org.uk>
 <CAKohpomU8wm0T=A7EkosdOjXbP8q2Cb726Hsjh08KTKYjoz3-A@mail.gmail.com>
Message-ID: <20150508105857.GB22845@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 12:17:44PM +0530, Viresh Kumar wrote:

> Thanks Mark. I have reworded it as:
> 
> - opp-microamp: Current drawn by the device in micro Amperes. It is used to set
>   the most efficient regulator operating mode.
> 
>   Should only be set if opp-microvolt is set for the OPP.
> 
>   Entries for multiple regulators must be present in the same order as
>   regulators are specified in device's DT node. If this property isn't required
>   for few regulators, then this should be marked as zero for them. If it isn't
>   required for any regulator, then this property need not be present.

> Please let me know if this looks fine now.

That should be fine, microamperes is usually one word.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150508/c3a301e7/attachment.sig>
