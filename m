From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Wed, 08 Jan 2014 13:24:22 +0100
Subject: Information about Atmel MXT224
In-Reply-To: <alpine.DEB.2.01.1401081228580.1454@pmeerw.net>
References: <52CD04F1.8090100@gmail.com>
 <alpine.DEB.2.01.1401081228580.1454@pmeerw.net>
Message-ID: <52CD4376.50305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2014 12:42 PM, Peter Meerwald wrote:

> you need to request them from the distributor I guess, they docs are
> pretty good

I am in Belgium and we deal with Gleichmann & Co. Electronics in Germany 
to have their devkit (SMT-C-T10). I have signed a NDA with them to have 
MXT224 protocol guide but they never send me Protocol Guide.
I will try another distributor.

> shouldn't this be 16/14?
You are right, I already try this and test it again but this does not 
change anything.

> something goes wrong in the initialization; the object table of the
> chip doesn't match the register data fed in -- the mxt224 can be a bitch
> and play dead

So what can I do ? Maybe a problem with the embedded firmware that need 
an update (atmel_mxt_ts 0-004b: Family ID: 129 Variant ID: 1 
Major.Minor.Build: 2.0.AB)

When I do cat /proc/interrupts and I short-circuit /CHG to ground, 
number increases so low-level handling of interrupt is working.

Thanks,
Ga?tan Carlier.
