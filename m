From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 26 Sep 2017 14:59:38 +0200
Subject: [PATCH v2 01/10] pinctrl: move gpio-axp209 to pinctrl
In-Reply-To: <20170926125518.kulkohinaojty2zl@flea>
References: <cover.1c314f4154a6d27354625f03d0a5269eee55a9c5.1506428208.git-series.quentin.schulz@free-electrons.com>
 <e193f8efe9092171ebeffb77ab77422179fd3cab.1506428208.git-series.quentin.schulz@free-electrons.com>
 <20170926125518.kulkohinaojty2zl@flea>
Message-ID: <cca522e6-1dbf-b682-b8fe-907fa293f335@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On 26/09/2017 14:55, Maxime Ripard wrote:
> On Tue, Sep 26, 2017 at 12:17:11PM +0000, Quentin Schulz wrote:
>> To prepare the driver for the upcoming pinctrl features, move the GPIO
>> driver AXP209 from GPIO to pinctrl subsystem.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> 
> I'm not sure we actually need to do this. Can't we just keep the
> driver here?
> 

That's not what I understood from:
https://lkml.org/lkml/2016/11/24/360 and the following answers from
Linus on the first version.

Quentin
-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/d1d18c30/attachment.sig>
