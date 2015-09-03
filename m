From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Sep 2015 16:18:54 +0100
Subject: [PATCH] ARM: dts: Add ddc i2c reference to veyron
In-Reply-To: <CAL_JsqL838-somj-o2QtxRA9bXon5dHijx22v0mVowqyhKgoUQ@mail.gmail.com>
References: <1441229148-12095-1-git-send-email-dianders@chromium.org>
 <CAL_JsqLLPCy6OpsP4NNjUA6+UxeTC-zGjGPPU+MLhUqFXSSGJQ@mail.gmail.com>
 <20150903082210.GU21084@n2100.arm.linux.org.uk>
 <CAL_JsqL838-somj-o2QtxRA9bXon5dHijx22v0mVowqyhKgoUQ@mail.gmail.com>
Message-ID: <20150903151854.GA21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 03, 2015 at 09:46:38AM -0500, Rob Herring wrote:
> Yes, that is fairly common (ADV75xx is same), and we would not
> describe an I2C bus in DT in that case. Same with HPD directly handled
> vs. a GPIO line. That is no different than what Doug has said:
> ddc-i2c-bus is present if using the SOC's I2C host and absent if using
> the HDMI block's DDC functionality. I'm only questioning the location
> of the property.

No, I don't think that's what Doug wants.  Doug wants the bridge's
internal I2C host to be exposed, so he can number it through a DT
alias.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
