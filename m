From: lho@apm.com (Loc Ho)
Date: Fri, 9 May 2014 09:17:28 -0700
Subject: [PATCH 1/4] edac: Fix MC scrub mode comparsion bug for
 correctable error
In-Reply-To: <20140509073803.GD8844@pd.tnic>
References: <1399590199-12256-1-git-send-email-lho@apm.com>
 <1399590199-12256-2-git-send-email-lho@apm.com>
 <20140509073803.GD8844@pd.tnic>
Message-ID: <CAPw-ZT=Eeu9iY9wQa5ndKj8_6FA_XS_9N4t39kPizbaZkQTAtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>> This patch fixes the MC scrub mode comparsion bug by replacing
>> '&' with '=='. The MC structure field scrub_mode is integer
>> type - not bit field.
>>
>> Signed-off-by: Loc Ho <lho@apm.com>
>
> Applied, thanks.

If I should need to submit future version of the X-Gene EDAC driver, I
will not include this patch.

-Loc
