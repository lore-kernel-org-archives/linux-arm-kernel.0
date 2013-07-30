From: zonque@gmail.com (Daniel Mack)
Date: Tue, 30 Jul 2013 09:48:51 +0200
Subject: [RFC PATCH 0/2] impedance-matcher generic improvements
In-Reply-To: <cover.1375131816.git.jason@lakedaemon.net>
References: <51F2A014.7000209@gmail.com>
 <cover.1375131816.git.jason@lakedaemon.net>
Message-ID: <51F76FE3.1080302@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On 29.07.2013 23:23, Jason Cooper wrote:
> Basic idea is to replace a device's stock kernel with this impedance-matcher.
> Load the kernel and/or the devicetree blob to desired addresses.  Add
> 'loadaddrs=0xXXXXXXXX,0xYYYYYYYY' to the kernel's command line.  Or, if you are
> appending, 'loadaddrs=appended,0xYYYYYYYY'.  First address is the location of
> the kernel, second is the location of the dtb.

Nice to see that idea implemented! For me though, changing any of the
U-Boot variables is out of the question, and I need the matcher just the
way I implemented it, including the LED blink pattern to let the user
know if things go wrong.

Hence, I won't change to your generic version on my boards, and so I
think it might be best if you maintain your own tree for your approach.


Best regards,
Daniel
