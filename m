From: j.anaszewski@samsung.com (Jacek Anaszewski)
Date: Tue, 18 Nov 2014 09:09:09 +0100
Subject: [RFC] adp1653: Add device tree bindings for LED controller
In-Reply-To: <20141117145857.GO8907@valkosipuli.retiisi.org.uk>
References: <20141116075928.GA9763@amd>
 <20141117145857.GO8907@valkosipuli.retiisi.org.uk>
Message-ID: <546AFEA5.9020000@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel, Sakari,

On 11/17/2014 03:58 PM, Sakari Ailus wrote:
> Hi Pavel,
>
> On Sun, Nov 16, 2014 at 08:59:28AM +0100, Pavel Machek wrote:
>> For device tree people: Yes, I know I'll have to create file in
>> documentation, but does the binding below look acceptable?
>>
>> I'll clean up driver code a bit more, remove the printks. Anything
>> else obviously wrong?
>
> Jacek Anaszewski is working on flash support for LED devices. I think it'd
> be good to sync the DT bindings for the two, as the types of devices
> supported by the LED API and the V4L2 flash API are quite similar.
>
> Cc Jacek.

I've already submitted a patch [1] that updates leds common bindings.
I hasn't been merged yet, as the related LED Flash class patch [2]
still needs some indicator leds related discussion [3].

I think this is a good moment to discuss the flash related led common
bindings.

[1] http://www.spinics.net/lists/linux-leds/msg02121.html
[2] http://www.spinics.net/lists/linux-media/msg83100.html
[3] http://www.spinics.net/lists/linux-leds/msg02472.html

Best Regards,
Jacek Anaszewski
