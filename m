From: abrestic@chromium.org (Andrew Bresticker)
Date: Tue, 26 May 2015 09:27:21 -0700
Subject: [PATCH v8 0/9] Tegra xHCI support
In-Reply-To: <CABb+yY2WhH2gGbCr4n=m9HOa_843MuZDp=QWNDHbtB8AMYYwYA@mail.gmail.com>
References: <1430761002-9327-1-git-send-email-abrestic@chromium.org>
 <CABb+yY2WhH2gGbCr4n=m9HOa_843MuZDp=QWNDHbtB8AMYYwYA@mail.gmail.com>
Message-ID: <CAL1qeaFT5qH3D5Lu8UZpwx-RY6FJUu74vfhsztToPi_zg1-1dQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

On Mon, May 11, 2015 at 8:56 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
> Applied patches 2, 3, 6 & 7

Please drop patches 6 and 7.  Lee Jones has NAK'ed the MFD driver, so
I'll have to re-spin this series without using an MFD.

Thanks,
andrew
