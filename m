From: tony.luck@intel.com (Luck, Tony)
Date: Thu, 29 Jun 2017 16:55:46 +0000
Subject: [PATCH] EDAC: Get rid of mci->mod_ver
In-Reply-To: <20170629100311.vmdq6fojpo5ye4ne@pd.tnic>
References: <20170629100311.vmdq6fojpo5ye4ne@pd.tnic>
Message-ID: <3908561D78D1C84285E8C5FCA982C28F612E6E02@ORSMSX114.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> any objections?
>
> ---
> It is a write-only variable so get rid of it.

Nope.  Zap it.

Acked-by: Tony Luck <tony.luck@intel.com>
