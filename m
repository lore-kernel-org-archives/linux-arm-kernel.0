From: julian.calaby@gmail.com (Julian Calaby)
Date: Tue, 2 Jun 2015 09:39:27 +1000
Subject: [linux-sunxi] [PATCH 1/2] clk: sunxi: Add support for the usb-clk
 on sun8i a23 and a33 SoCs
In-Reply-To: <1433183008-13086-1-git-send-email-hdegoede@redhat.com>
References: <1433183008-13086-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGRGNgXHa1K=xmF8_R9y8RJT6Y-zxmfsU19_V41gweqaZg+hVg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Tue, Jun 2, 2015 at 4:23 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> The usb-clk on sun8i a23 and a33 SoCs is similar to the ones found
> on sun6i-a31 SoCs but instead of a 3th phy the a23 / a33 have a hsic
> interface which gets enabled by almost the same bits as used on
> the a31 for the 3th phy, but not exactly the same bits so we need
> a new compatible for this.

Minor spelling note: it's "3rd" not "3th".

Thanks,

-- 
Julian Calaby

Email: julian.calaby at gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
