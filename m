From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 7 Nov 2018 23:54:00 -0200
Subject: [PATCH v2 4/9] arm64: defconfig: Drop USB_ULPI_BUS and
 USB_CHIPIDEA_ULPI
In-Reply-To: <7b7c52f5-a572-03dd-8bae-814cf6c4a5a6@free.fr>
References: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
 <7b7c52f5-a572-03dd-8bae-814cf6c4a5a6@free.fr>
Message-ID: <CAOMZO5AomNbs7Css8EJKGhJajEoGvNAT4RRjikr5EbJxHuFqmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2018 at 9:17 PM Marc Gonzalez <marc.w.gonzalez@free.fr> wrote:
>
> Commit a930d8bd94d8 ("usb: chipidea: Always build ULPI code") made
> USB_CHIPIDEA select USB_ULPI_BUS, and removed USB_CHIPIDEA_ULPI.
>
> Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
