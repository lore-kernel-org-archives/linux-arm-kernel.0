From: svellattu@mvista.com (Silesh C V)
Date: Wed, 10 Oct 2018 08:25:40 +0530
Subject: [PATCH v3 1/2] Driver core: add bus_find_device_by_fwnode
In-Reply-To: <CANLsYkxcUvBBFRFD9Vco559Y5LFw=X0H3Lyzm=nFat6z5yH44g@mail.gmail.com>
References: <1539080245-25818-1-git-send-email-svellattu@mvista.com>
 <20181009172726.GA2182@xps15>
 <CAJZ5v0gckkg0jyTc7=JYPpUruQQXL_FhEjm03-0mrFcxH60cHA@mail.gmail.com>
 <CANLsYkxcUvBBFRFD9Vco559Y5LFw=X0H3Lyzm=nFat6z5yH44g@mail.gmail.com>
Message-ID: <CALabi0FxU6GQVhKUWFzGF8qLS2YrQNh6Nok+RMS3Q_7B4NRH-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mathieu,

Thank you for the review.

On Tue, Oct 9, 2018 at 11:18 PM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
>
> In this case I don't see a reason not to abide to the guideline.
> Wrapping the function declaration to 80 characters would be easy
> without effecting code readability.
>

I had seen this warning but thought it looked better as is. But now,
as I have to resend the patches after rebasing on linux-next, I will
fix this too in v4.

Thanks,
Silesh
