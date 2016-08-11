From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 11 Aug 2016 11:15:52 +0200
Subject: [PATCH 1/2] dt: bindings: Add vendor prefix for Espressif System
In-Reply-To: <20160810184845.GA17829@rob-hp-laptop>
References: <1470596269-20572-1-git-send-email-hdegoede@redhat.com>
 <20160810184845.GA17829@rob-hp-laptop>
Message-ID: <2b43330e-369d-7473-8b73-429f0f0b73ce@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 10-08-16 20:48, Rob Herring wrote:
> On Sun, Aug 07, 2016 at 08:57:48PM +0200, Hans de Goede wrote:
>> Espressif is a manufacturer of various wifi and bt chips, add a vendor
>> prefix for use with bindings for these chips.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>>  1 file changed, 1 insertion(+)
>
> Acked-by: Rob Herring <robh@kernel.org>

Thank you for all the reviews.

What about: "[PATCH 2/2] dt: bindings: Add binding for ESP8089 wifi chips" ?
there were some remarks, but I believe that those have been addressed
(by answering the remarks, not with a new version), so a review of that
one would be appreciated too.

Also who should merge this series, Ulf because it is mmc related,
or the dt-maintainers since it contains only bindings patches ?

Regards,

Hans
