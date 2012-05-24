From: cjb@laptop.org (Chris Ball)
Date: Thu, 24 May 2012 10:40:07 -0400
Subject: [PATCH v4 1/3] mmc: atmel-mci: add device tree support
In-Reply-To: <20120524094304.GH3377@game.jcrosoft.org> (Jean-Christophe
 PLAGNIOL-VILLARD's message of "Thu, 24 May 2012 11:43:04 +0200")
References: <1337681352-18521-2-git-send-email-ludovic.desroches@atmel.com>
 <1337757830-19361-1-git-send-email-ludovic.desroches@atmel.com>
 <20120524094304.GH3377@game.jcrosoft.org>
Message-ID: <878vghfxrs.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 24 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> +
>> +		pdata->slot[slot_id].detect_is_active_high =
>> +			of_property_read_bool(cnp, "cd-inverted");
> 
> I really this this is redondant with gpio binding
>
> Chris??

Hm, I think go ahead and add it for now -- I agree it's redundant, but
we should go through and remove the redundancy from all drivers (and the
binding document, which is in 3.5-rc1 now) at once later.  Since it's in
the bindings doc, best to implement it until that changes.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
