From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Feb 2012 08:38:33 +0000
Subject: RFC: what do we do with system controllers?
In-Reply-To: <CACRpkdY1W-RGE0JL4Sx5UcPY-EGieu8vo7H0fp9xyXtegpaaKw@mail.gmail.com>
References: <CACRpkdY1W-RGE0JL4Sx5UcPY-EGieu8vo7H0fp9xyXtegpaaKw@mail.gmail.com>
Message-ID: <20120228083833.GB18045@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 28, 2012 at 06:48:12AM +0100, Linus Walleij wrote:
> Mainly addressed to Greg but anyone is welcome to join the
> discussion...
> 
> Several ARM platforms have system controllers. In this I
> include all custom terminology such as:
> 
> - System Control
> - Chip Controller
> - Core Module control registers
> - Power Reset Control Management Units
> - Multimedia Communications Port

Why do you include this?  If you include this, you should include things
like SSP/SPI ports, I2C and other such buses.
