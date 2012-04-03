From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 03 Apr 2012 17:04:20 +0200
Subject: [PATCH v2 06/13] USB: ohci-at91: change maximum number of ports
In-Reply-To: <Pine.LNX.4.44L0.1204030954590.1537-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1204030954590.1537-100000@iolanthe.rowland.org>
Message-ID: <4F7B1174.5070300@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2012 04:11 PM, Alan Stern :
> On Tue, 3 Apr 2012, Nicolas Ferre wrote:
> 
>> Change number of ports to 3 for newer SoCs. Modify pdata structure
>> and ohci-at91 code that was dealing with ports information and check
>> of port indexes.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> Did you run this patch through scripts/checkpatch.pl?  I have the 
> feeling that it might complain about some of the changes.

Yes, definitively.

I can modify the patch to comply with error issued by checkpatch.pl: several are
due to a bad replacement of previous code with my regular expression but others
where existing before my modifications.
So what do you think about:
 - addressing all style errors in this patch (to prevent carrying them)
 - merging this one and the following patch:
   "[PATCH v2 07/13] USB: ohci-at91: coding style modifications with one-line ifs
 - posting a v3 of this patch only if you agree on this...

Best regards,
-- 
Nicolas Ferre
