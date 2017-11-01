From: gengdongjiu@huawei.com (gengdongjiu)
Date: Wed, 1 Nov 2017 12:13:35 +0800
Subject: [RFC/RFT PATCH 3/6] ACPI / APEI: Replace ioremap_page_range()
 with fixmap
In-Reply-To: <20171031153832.17746-4-james.morse@arm.com>
References: <20171031153832.17746-1-james.morse@arm.com>
 <20171031153832.17746-4-james.morse@arm.com>
Message-ID: <3b796e66-1618-0a6e-e57e-99323514b84d@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2017/10/31 23:38, James Morse wrote:
> CC'd people I've seen posting CPER log fragments, could you give this a
> test on your platforms?
Thanks for the fixing, not found obviously issue.
