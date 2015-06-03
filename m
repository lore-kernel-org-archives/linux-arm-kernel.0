From: pratyush.anand@gmail.com (Pratyush Anand)
Date: Wed, 3 Jun 2015 17:15:52 +0530
Subject: [PATCH Part1 v11 3/5] PCI: designware: Use pci_scan_root_bus()
 for simplicity
In-Reply-To: <000301d09888$09d01370$1d703a50$@com>
References: <000301d09888$09d01370$1d703a50$@com>
Message-ID: <CAHM4w1mGB1GET6s-rkLs-0=Cqc4-zEm5q9-i8vxpFGgjf-V8JA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 7:48 PM, Jingoo Han <jingoohan1@gmail.com> wrote:
> On Tue, 28 Apr 2015 15:01:37 +0800, Yijing Wang wrote:
>
>> Pci_bus_add_devices() was ripped out of pci_scan_root_bus().
>> Now pci_scan_root_bus() == pci_create_root_bus() +
>> pci_scan_child_bus() if busn resource is supplied.
>> Designware added the busn resource to resources list
>> in dw_pcie_setup(). So it should be safe to use
>> pci_scan_root_bus() instead.
>>
>> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
>> CC: Mohit Kumar <mohit.kumar@st.com>
>> CC: Jingoo Han <jg1.han@samsung.com>
>
> +cc: Pratyush Anand, Lucas Stach
>
> Acked-by: Jingoo Han <jingoohan1@gmail.com>



Looks fine to me:
Acked-by: Pratyush Anand <pratyush.anand@gmail.com>
