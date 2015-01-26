From: mark.roszko@gmail.com (Mark Roszko)
Date: Mon, 26 Jan 2015 12:19:23 -0500
Subject: [PATCH] at91: i2c-at91: improve time-out handling
In-Reply-To: <54C41FD0.2010607@interlog.com>
References: <54A58BA5.3080003@interlog.com>
 <20150107103113.GA30897@ldesroches-Latitude-E6320>
 <20150113152752.GK7660@katana> <54C41FD0.2010607@interlog.com>
Message-ID: <CAJjB1qJSBzwviN7Ey+9AHmiEy1PcTKOnPOWVc8xFCZmfkW-BRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You can check if ret == -ETIMEDOUT in the error path instead of
allocating another variable.

You also generated the patch with your /arch/arm/boot/dts/Makefile changes.
