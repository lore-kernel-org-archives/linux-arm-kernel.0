From: jagan@amarulasolutions.com (Jagan Teki)
Date: Tue, 12 Dec 2017 14:57:01 +0530
Subject: [PATCH] arm64: allwinner: a64: a64-olinuxino: add usb otg
In-Reply-To: <20171212081335.3qkqcofdbcfuu5zh@flea.lan>
References: <1513058169-25516-1-git-send-email-jagan@amarulasolutions.com>
 <20171212081335.3qkqcofdbcfuu5zh@flea.lan>
Message-ID: <CAMty3ZDEhXjHTE4WsJK8=yAayuR=qvJQaZEjGq=LDS6Y4V7RFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 12, 2017 at 1:43 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Tue, Dec 12, 2017 at 11:26:09AM +0530, Jagan Teki wrote:
>> Add usb otg support for a64-olinuxino board,
>> - USB0-ID connected with PH9
>> - USB0-VBUSDET connected with PH6
>> - USB-DRVVBUS controlled by N_VBUSEN pin from PMIC
>>
>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> How was this tested? Did you test the OTG part, or only the peripheral
> part?

Yes peripheral.
