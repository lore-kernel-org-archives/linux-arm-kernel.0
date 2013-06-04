From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Tue, 4 Jun 2013 08:32:58 -0400
Subject: [PATCHv2 1/3] arm: introduce config HAS_BANDGAP
In-Reply-To: <CAOMZO5CL=apxbkCHA6Xsw+m5d-rhe_VcOaA9KpkSmiJ=ZRL7gA@mail.gmail.com>
References: <1368629928-6723-1-git-send-email-eduardo.valentin@ti.com>
 <1368629928-6723-2-git-send-email-eduardo.valentin@ti.com>
 <CAOMZO5CL=apxbkCHA6Xsw+m5d-rhe_VcOaA9KpkSmiJ=ZRL7gA@mail.gmail.com>
Message-ID: <51ADDE7A.6090205@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio,

On 31-05-2013 11:12, Fabio Estevam wrote:
> On Wed, May 15, 2013 at 11:58 AM, Eduardo Valentin
> <eduardo.valentin@ti.com> wrote:
>> Introduce HAS_BANDGAP config entry. This config is a
>> boolean value so that arch code can flag is they
>> feature a bandgap device.
>>
>> This config entry follows the same idea behind
>> ARCH_HAS_CPUFREQ.
> 
> It would be nice if you explain what BANDGAP means here, since you
> introduce this option in this patch.
> 
> 

Yeah, I didnt do it because bandgap is a common term used in digital
circuits [1,2]. Also, as in this patch we do not add term different from
the common used bandgap term, I believe it is self explanatory.

I any case, I am resending with minor explanation.

[1] - http://en.wikipedia.org/wiki/Bandgap_voltage_reference
[2] - http://en.wikipedia.org/wiki/Silicon_bandgap_temperature_sensor

-- 
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130604/28b8ba3c/attachment.sig>
