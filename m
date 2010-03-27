From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 27 Mar 2010 21:42:25 +0000
Subject: [PATCH] Including device.h and resource.h header files in
	linux/amba/bus.h
In-Reply-To: <1269511413-30621-1-git-send-email-viresh.kumar@st.com>
References: <1269511413-30621-1-git-send-email-viresh.kumar@st.com>
Message-ID: <20100327214225.GA13203@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 25, 2010 at 03:33:32PM +0530, Viresh KUMAR wrote:
> linux/amba/bus.h have dependencies on linux/device.h and linux/resource.h, but
> it doesn't include them. We get compilation errors in our files which include
> bus.h but doesn't include device.h and resource.h. This patch includes device.h
> and resource.h in linux/amba/bus.h file.

Ok.
