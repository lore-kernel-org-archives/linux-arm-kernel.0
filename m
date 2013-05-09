From: srinivas.kandagatla@st.com (Srinivas KANDAGATLA)
Date: Thu, 09 May 2013 15:51:17 +0100
Subject: [RFC 2/8] ARM:global_timer: Add ARM global timer support.
In-Reply-To: <201305091651.13896.arnd@arndb.de>
References: <1368022187-1633-1-git-send-email-srinivas.kandagatla@st.com>
 <201305081638.23100.arnd@arndb.de> <518BADBF.4070303@st.com>
 <201305091651.13896.arnd@arndb.de>
Message-ID: <518BB7E5.4070402@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/13 15:51, Arnd Bergmann wrote:
> It won't.
> 
>> > Looking at the code in clocksource_of_init it just goes through the
>> > of_device_id table, which is not used in case of non-DT.
> All new platforms are DT-only, and none of the old platforms use this
> driver, so it does not matter.
> 
It makes sense, I will remove the header file.
> 	Arnd
> 
