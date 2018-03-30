From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 30 Mar 2018 18:37:49 +0800
Subject: [PATCH 1/3] iio: adc: meson-saradc: squash and share the common
 adc platform data
In-Reply-To: <20180330104813.7dd79bd5@archlinux>
References: <20180326084629.100070-1-yixun.lan@amlogic.com>
 <20180326084629.100070-2-yixun.lan@amlogic.com>
 <20180330104813.7dd79bd5@archlinux>
Message-ID: <c0dde5a6-c490-c8ea-5652-bcc27ee9f0e7@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/30/18 17:48, Jonathan Cameron wrote:
> On Mon, 26 Mar 2018 16:46:27 +0800
> Yixun Lan <yixun.lan@amlogic.com> wrote:
> 
>> Extract and promote common adc platform data into a new structure,
>> to make it better share the info between several SoCs,
>> this will avoid duplicating the code all over the place,
>> Save a few memory and make the code more maintainable.
>>
>> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.

Hi Jonathan

  Great! Thanks for taking these

Yixun
