From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Fri, 15 Dec 2017 20:25:17 +0100
Subject: [PATCH  1/2] serial: stm32: add default console
In-Reply-To: <1512146211-29086-2-git-send-email-ludovic.Barre@st.com>
References: <1512146211-29086-1-git-send-email-ludovic.Barre@st.com>
 <1512146211-29086-2-git-send-email-ludovic.Barre@st.com>
Message-ID: <20171215192517.GA27395@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 01, 2017 at 05:36:50PM +0100, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds by default the console support
> on stm32.

Why?  'default y' should only mean "machine will not boot without this".
And I think your machine will boot without the console, right?  :)

thanks,

greg k-h
