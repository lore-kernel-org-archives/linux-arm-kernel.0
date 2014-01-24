From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 24 Jan 2014 08:28:59 +0000
Subject: [PATCH v2 2/4] pinctrl: st: Add software edge trigger interrupt
 support.
In-Reply-To: <CACRpkdaBAnpfHBqkgU2emZrYwHGh9KvDvqfnCvaWdU5jYgxStA@mail.gmail.com>
References: <1389886545-31498-1-git-send-email-srinivas.kandagatla@st.com>
 <1389886651-31990-1-git-send-email-srinivas.kandagatla@st.com>
 <CACRpkdaBAnpfHBqkgU2emZrYwHGh9KvDvqfnCvaWdU5jYgxStA@mail.gmail.com>
Message-ID: <20140124082859.GJ8586@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > +/*
> > + * As edge triggers are not supported at hardware level, it is supported by
> > + * software by exploiting the level trigger support in hardware.
> 
> (...)
> 
> All this is quite hard to understand. Maybe it's just because
> it's hard overall. Edge triggers are not supported by hardware
> so we use the hardware edge trigger support?
> 
> That is a bit oxymoronic...

That's not what is says. Read it again. :)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
