From: notasas@gmail.com (Grazvydas Ignotas)
Date: Fri, 12 Oct 2012 17:51:51 +0300
Subject: [RFC 00/24] OMAP serial driver flow control fixes, and
 preparation for DMA engine conversion
In-Reply-To: <50769D8C.8030401@ti.com>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
 <507427DA.6020409@ti.com> <87mwzuxjtc.fsf@deeprootsystems.com>
 <507694CF.3020204@ti.com>
 <20121011095443.GH28061@n2100.arm.linux.org.uk>
 <50769D8C.8030401@ti.com>
Message-ID: <CANOLnOOewDVnsTmh9YyYCyG-5BrwDsTbSqDahazPsnM-6wBQYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 11, 2012 at 1:21 PM, Sourav <sourav.poddar@ti.com> wrote:
> If you have any pointers on how to test hardware flow control, I will like
> to do that on my beagle board.

If you can find some board with BT chip connected to UART, that would
be a good test as they usually have flow control lines connected and
can run at high bitrates. I think some EVM or Zoom boards have BT
chips.


-- 
Gra?vydas
