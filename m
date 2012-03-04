From: alan@signal11.us (Alan Ott)
Date: Sun, 04 Mar 2012 14:46:28 -0500
Subject: [PATCH v2 5/6] ARM: tegra: USB_ULPI needs USB
In-Reply-To: <20120304184015.GE31064@quad.lixom.net>
References: <1330721919-8800-1-git-send-email-alan@signal11.us>
 <20120304184015.GE31064@quad.lixom.net>
Message-ID: <4F53C694.5060308@signal11.us>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/4/12 1:40 PM, Olof Johansson wrote:
> On Fri, Mar 02, 2012 at 03:58:39PM -0500, Alan Ott wrote:
>> From: Arnd Bergmann<arnd@arndb.de>
>>
>> The USB_ULPI driver is selected by tegra, but can only be
>> built if at least one of USB or USB_GADGET is enabled.
>> The kernel fails to link if both are off.
>>
>> Signed-off-by: Arnd Bergmann<arnd@arndb.de>
>> Signed-off-by: Alan Ott<alan@signal11.us>
>> ---
> This is another patch that needs the same change for T30.
>
>
> -Olof

It is in v3. It looks like you took (or at least replied to) v2 for all 
these.

Alan.
