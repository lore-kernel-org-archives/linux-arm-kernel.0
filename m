From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Apr 2012 14:42:38 +0000
Subject: [PATCH V4 1/5] of: Implement managed of_iomap()
In-Reply-To: <6a0872f9d8959bc9d66d179e4911d6f09a219b42.1334548272.git.viresh.kumar@st.com>
References: <cover.1334548272.git.viresh.kumar@st.com>
 <6a0872f9d8959bc9d66d179e4911d6f09a219b42.1334548272.git.viresh.kumar@st.com>
Message-ID: <201204161442.38725.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 April 2012, Viresh Kumar wrote:
> This simplifies cleanup paths of user code by providing managed version of
> of_iomap().
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>


This one looks good,

Acked-by: Arnd Bergmann <arnd@arndb.de>

but I wonder if we should also have a devm_of_request_and_ioremap
(maybe with a shorter name) that combines this with request_resource.

	Arnd
