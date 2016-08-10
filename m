From: patrice.chotard@st.com (Patrice Chotard)
Date: Wed, 10 Aug 2016 08:50:31 +0200
Subject: [STLinux Kernel] [PATCH] i2c: don't print error when adding
 adapter fails
In-Reply-To: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
Message-ID: <dda2b522-0257-17c7-1332-cbc026b74603@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2016 01:36 PM, Wolfram Sang wrote:
> Since v4.8-rc1, the I2C core will print detailed information when adding an I2C
> adapter fails. So, drivers can skip this now.
>
> I am still undecided if I apply this as a single patch or break it out. But for
> reviewing, avoiding the patch bomb is probably a good thing.
>
> Should go via subsystem tree, I'd think.
>
> Wolfram Sang (1):
>   i2c: don't print error when adding adapter fails
>
>  drivers/i2c/busses/i2c-st.c             | 4 +---
>

For i2c-st.c

Acked-by: Patrice Chotard <patrice.chotard@st.com>

Thanks
