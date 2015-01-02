From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Jan 2015 10:30:16 +0100
Subject: [PATCH] mfd: db8500-prcmu:  Remove unused function
In-Reply-To: <1420134593-690-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
References: <1420134593-690-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Message-ID: <1885645.kVZgiLLSZ0@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 January 2015 18:49:53 Rickard Strandqvist wrote:
> Remove the function prcmu_get_boot_status() that is not used anywhere.
> 
> This was partially found by using a static code analysis program called cppcheck.
> 
> Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
