From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 5 Apr 2010 06:10:28 +0200
Subject: [PATCH 1/3] WM8750: Convert to new API
In-Reply-To: <1270440005-25459-1-git-send-email-marek.vasut@gmail.com>
References: <1270440005-25459-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <201004050610.28610.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 5. dubna 2010 06:00:03 Marek Vasut napsal(a):
> Register the WM8750 as a SPI or I2C device. This patch mostly shuffles code
> around. Hugely inspired by WM8753 which was already converted.
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

Sorry, I'll send this one more time. I'll roll checkpatch fixes into this patch 
(as the lines checkpatch marked were moved anyway).
