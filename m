From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 21 Oct 2014 09:21:59 -0700
Subject: [PATCH v2 3/4] ARM: dts: sun5i: Add lradc node
In-Reply-To: <1413879890-7254-4-git-send-email-hdegoede@redhat.com>
References: <1413879890-7254-1-git-send-email-hdegoede@redhat.com>
 <1413879890-7254-4-git-send-email-hdegoede@redhat.com>
Message-ID: <20141021162159.GC8609@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Tue, Oct 21, 2014 at 10:24:49AM +0200, Hans de Goede wrote:
> +			button at 98 {
> +				label = "Home";
> +				linux,code = <KEY_HOME>;

I do not think you really want KEY_HOME (go to the beginning of the
line) here, KEY_HOMEPAGE or similar would suit better.

> +				channel = <0>;
> +				voltage = <987387>;
> +			};
> +		};

Thanks.

-- 
Dmitry
