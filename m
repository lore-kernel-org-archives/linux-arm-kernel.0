From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Sat, 11 Oct 2014 16:00:17 +0200
Subject: [PATCH v4] ARM: sun7i: add support for A20-OLinuXino-Lime2
In-Reply-To: <20141010135643.GN19438@lukather>
References: <20140928164337.GB15315@lukather> <54295711.9010901@gmail.com>
 <20140929132543.GC4081@lukather> <54296D8B.3080304@gmail.com>
 <20141002124807.GC4039@lukather> <5431C8EF.3070809@gmail.com>
 <20141006092049.GF4090@lukather> <54366326.3060303@gmail.com>
 <20141009195630.GJ19438@lukather> <5437DC04.6070000@gmail.com>
 <20141010135643.GN19438@lukather>
Message-ID: <543937F1.3050105@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 10.10.2014 um 15:56 schrieb Maxime Ripard:
> On Fri, Oct 10, 2014 at 02:15:48PM +0100, Iain Paton wrote:
>> On 09/10/14 20:56, Maxime Ripard wrote:
>>> Sorry for noticing this so late, but we sort the DT nodes by their
>>> base address. Could you respin this for another version?
>>
>> Sure, no problem, on it's way shortly.
>>
>> Is there any general rule for this sort of thing, or is this something 
>> specific to sunxi?   
>>
>> Asking mainly as I've been asked to do them alphabetically previously 
>> by a different maintainer and that's esentially why I did it the same 
>> way here.
>>
>> Everyone having different undocumented conventions seems likely to 
>> become counter productive eventually.
> 
> That's unusual, it should be a global convention at least for ARM.

>From what I understood it's by unit address for foo at 12345678 and
alphabetically for &foo. So there is both actually, plus existing
inconsistencies. :)

Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141011/c5fc63c1/attachment-0001.sig>
