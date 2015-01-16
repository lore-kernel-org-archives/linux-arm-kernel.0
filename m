From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Jan 2015 11:01:59 +0100
Subject: [PATCH 18/28] PCI/sparc: Use pci_scan_root_bridge() for simplicity
In-Reply-To: <1421372666-12288-19-git-send-email-wangyijing@huawei.com>
References: <1421372666-12288-1-git-send-email-wangyijing@huawei.com>
 <1421372666-12288-19-git-send-email-wangyijing@huawei.com>
Message-ID: <2658988.B0VmbMPdJ9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 January 2015 09:44:16 Yijing Wang wrote:
> +static void pci_host_bridge_probe_mode(
> +               struct pci_host_bridge *host)
> +{
> +       host->of_scan = true;
> +}
> 

I probably missed something here, but where does host->of_scan
get used?

	Arnd
